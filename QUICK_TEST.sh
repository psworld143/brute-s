#!/bin/bash
# Quick test script for macOS
# This script runs a complete test sequence

echo "========================================="
echo "  h4g-client macOS Test Suite"
echo "========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counter
TESTS_PASSED=0
TESTS_FAILED=0

# Function to run test
run_test() {
    local test_name=$1
    local command=$2
    
    echo -e "${YELLOW}Testing: ${test_name}${NC}"
    if eval "$command" > /dev/null 2>&1; then
        echo -e "${GREEN}✓ PASSED${NC}"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}✗ FAILED${NC}"
        ((TESTS_FAILED++))
    fi
    echo ""
}

# Check prerequisites
echo "Checking prerequisites..."
echo ""

# Check Python
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version)
    echo -e "${GREEN}✓ Python found: ${PYTHON_VERSION}${NC}"
else
    echo -e "${RED}✗ Python 3 not found${NC}"
    exit 1
fi

# Check API
echo "Checking API accessibility..."
if curl -s http://localhost/h4g/api.php > /dev/null 2>&1; then
    echo -e "${GREEN}✓ API is accessible${NC}"
else
    echo -e "${RED}✗ API not accessible. Make sure XAMPP is running!${NC}"
    exit 1
fi

echo ""
echo "========================================="
echo "  Running Tests"
echo "========================================="
echo ""

# Test 1: Save data
run_test "Save data (Python script)" "python3 client.py -e quick_test test1"

# Test 2: Display all
run_test "Display all records (Python script)" "python3 client.py -d"

# Test 3: Search by keyword
run_test "Search by keyword (Python script)" "python3 client.py -d quick_test"

# Test 4: Executable exists
if [ -f "dist/h4g-client" ]; then
    echo -e "${YELLOW}Testing: Executable exists${NC}"
    echo -e "${GREEN}✓ PASSED${NC}"
    ((TESTS_PASSED++))
    echo ""
    
    # Test 5: Executable save
    run_test "Save data (Executable)" "./dist/h4g-client -e exec_test exec1"
    
    # Test 6: Executable display
    run_test "Display all (Executable)" "./dist/h4g-client -d"
else
    echo -e "${YELLOW}Executable not found. Skipping executable tests.${NC}"
    echo "Run './build.sh' to build the executable first."
    echo ""
fi

# Summary
echo "========================================="
echo "  Test Summary"
echo "========================================="
echo -e "${GREEN}Tests Passed: ${TESTS_PASSED}${NC}"
if [ $TESTS_FAILED -gt 0 ]; then
    echo -e "${RED}Tests Failed: ${TESTS_FAILED}${NC}"
else
    echo -e "${GREEN}Tests Failed: ${TESTS_FAILED}${NC}"
fi
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}✗ Some tests failed${NC}"
    exit 1
fi

