<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// Database configuration
$host = 'localhost';
$dbname = 'h4g_db';
$username = 'root';
$password = '';

// Encryption configuration
define('ENCRYPTION_KEY', 'ndmu2025');
define('ENCRYPTION_METHOD', 'AES-256-CBC');

function getEncryptionKey() {
    return hash('sha256', ENCRYPTION_KEY, true);
}

function encrypt_data($plaintext) {
    $key = getEncryptionKey();
    // Use deterministic IV derived from plaintext for searchability
    // This ensures the same plaintext always encrypts to the same ciphertext
    $iv = substr(md5($plaintext, true), 0, 16);
    $encrypted = openssl_encrypt($plaintext, 'AES-256-CBC', $key, OPENSSL_RAW_DATA, $iv);
    return base64_encode($iv . $encrypted);
}

function decrypt_data($encrypted_data) {
    $key = getEncryptionKey();
    $data = base64_decode($encrypted_data);
    $iv = substr($data, 0, 16);
    $encrypted = substr($data, 16);
    return openssl_decrypt($encrypted, 'AES-256-CBC', $key, OPENSSL_RAW_DATA, $iv);
}

try {
    // Connect to MySQL database
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    if ($_SERVER['REQUEST_METHOD'] === 'GET') {
        $search_term = isset($_GET['keyword']) ? $_GET['keyword'] : '';
        
        if (empty($search_term)) {
            $sql = "SELECT id, keyword, flag FROM data ORDER BY id";
            $stmt = $pdo->prepare($sql);
            $stmt->execute();
            $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
        } else {
            // Get all records and filter by decrypting keywords
            $sql = "SELECT id, keyword, flag FROM data ORDER BY id";
            $stmt = $pdo->prepare($sql);
            $stmt->execute();
            $all_results = $stmt->fetchAll(PDO::FETCH_ASSOC);
            
            // First, check for exact matches
            $exact_matches = [];
            $partial_matches = [];
            
            foreach ($all_results as $record) {
                try {
                    $decrypted_keyword = decrypt_data($record['keyword']);
                    // Case-insensitive exact match
                    if (strcasecmp($decrypted_keyword, $search_term) === 0) {
                        $exact_matches[] = $record;
                    } else {
                        // Case-insensitive partial match (only if no exact match found yet)
                        if (stripos($decrypted_keyword, $search_term) !== false) {
                            $partial_matches[] = $record;
                        }
                    }
                } catch (Exception $e) {
                    // Skip records that can't be decrypted
                    continue;
                }
            }
            
            // If exact matches exist, return only those; otherwise return partial matches
            if (count($exact_matches) > 0) {
                $results = $exact_matches;
            } else {
                $results = $partial_matches;
            }
        }
        
        http_response_code(200);
        echo json_encode([
            'success' => true,
            'keyword' => $search_term,
            'count' => count($results),
            'flags' => $results
        ]);
        exit();
    }
    
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $input = file_get_contents('php://input');
        $data = json_decode($input, true);
        
        if (!$data) {
            http_response_code(400);
            echo json_encode(['error' => 'Invalid request']);
            exit();
        }
        
        $required_fields = ['keyword', 'flag'];
        foreach ($required_fields as $field) {
            if (!isset($data[$field]) || empty($data[$field])) {
                http_response_code(400);
                echo json_encode(['error' => 'Invalid request']);
                exit();
            }
            $trimmed = trim($data[$field]);
            if (empty($trimmed)) {
                http_response_code(400);
                echo json_encode(['error' => 'Invalid request']);
                exit();
            }
        }
        
        $encrypted_keyword = $data['keyword'];
        $encrypted_flag = $data['flag'];
        
        // Check if duplicate exists (same keyword and flag)
        $check_sql = "SELECT id FROM data WHERE keyword = :keyword AND flag = :flag LIMIT 1";
        $check_stmt = $pdo->prepare($check_sql);
        $check_stmt->bindParam(':keyword', $encrypted_keyword, PDO::PARAM_STR);
        $check_stmt->bindParam(':flag', $encrypted_flag, PDO::PARAM_STR);
        $check_stmt->execute();
        
        if ($check_stmt->fetch()) {
            // Duplicate exists, don't insert
            http_response_code(200);
            echo json_encode([
                'success' => true,
                'message' => 'Data already exists',
                'id' => null
            ]);
            exit();
        }
        
        $sql = "INSERT INTO data (keyword, flag) VALUES (:keyword, :flag)";
        $stmt = $pdo->prepare($sql);
        
        $stmt->bindParam(':keyword', $encrypted_keyword, PDO::PARAM_STR);
        $stmt->bindParam(':flag', $encrypted_flag, PDO::PARAM_STR);
        
        $stmt->execute();
        
        $insertId = $pdo->lastInsertId();
        
        http_response_code(201);
        echo json_encode([
            'success' => true,
            'message' => 'Data saved successfully',
            'id' => $insertId
        ]);
        exit();
    }
    
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
    
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Server error']);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Server error']);
}
?>

