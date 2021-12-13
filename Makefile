.PHONY: compile_solidity_destributor_test compile_go_destributor_test compile_destributor_test
.PHONY: compile_test

.PHONY: clean_test_abi clean_test_bin clean_test_go
.PHONY: clean_test

.PHONY: clean_build_sol clean_build_abi clean_build_bin clean_build_go
.PHONY: clean_build

.PHONY: copy_libs_to_build copy_destributor_to_build
.PHONY: copy_to_build

.PHONY: compile_build

.PHONY: all

# Compiling test

compile_solidity_destributor_test:
	@echo "compiling destributor solidity source into abi and bin files"
	solc -o ./test --optimize --optimize-runs=50000 --abi --bin --overwrite ./test/Destributor.sol

compile_go_destributor_test:
	@echo "compiling destributor abi and bin files to golang bindings"
	abigen --abi ./test/Destributor.abi --bin ./test/Destributor.bin -pkg destributor -type Destributor -out ./test/destributor/destributor.go

compile_destributor_test: compile_solidity_destributor_test compile_go_destributor_test

compile_test: compile_destributor_test

# Cleaning

clean_test_abi:
	@echo "removing abi files from /test dirs"
	rm test/*.abi

clean_test_bin:
	@echo "removing binary files from /test dirs"
	rm test/*.bin

clean_test_go:
	@echo "removing golang bindings from /test dirs"
	rm test/**/*.go

clean_test: clean_test_abi clean_test_bin clean_test_go

clean_build_sol:
	@echo "removing solidity files from /build dirs"
	rm build/*.sol

clean_build_abi:
	@echo "removing abi files from /build dirs"
	rm build/*.abi

clean_build_bin:
	@echo "removing binary files from /build dirs"
	rm build/*.bin

clean_build_go:
	@echo "removing golang bindings from /build dirs"
	rm build/**/*.go

clean_build: clean_build_sol clean_build_abi clean_build_bin clean_build_go

# Copying

copy_libs_to_build:
	@echo "copying library and interface files to build"
	cp test/Interfaces.sol build/
	cp test/MerkleProof.sol build/

copy_destributor_to_build:
	@echo "copying destributor to build"
	cp test/Destributor.sol build/

copy_to_build: copy_libs_to_build copy_destributor_to_build

# Compiling build

compile_build:
	@echo "compiling destributor build source into deploy ready files"
	solc -o ./build --optimize --optimize-runs=50000 --abi --bin --overwrite ./build/Destributor.sol
	abigen --abi ./build/Destributor.abi --bin ./build/Destributor.bin -pkg destributor -type Destributor -out ./build/destributor/destributor.go

all: clean_test compile_test clean_build copy_to_build compile_build
