// Data Type: Switched from u128 to felt252
// Storage Mechanism: added a LegacyMap to associate numbers with addresses
// Added get_caller_address() function to our set_number and get_number functions
// Changed the name of our storage variable from stored_data to numbers
// Changed the name of our external functions, from get to get_number and set to set_number

#[starknet::interface]
trait ISimpleStorage<TContractState> {
    fn set_number(ref self: TContractState, number: u64);
    fn get_number(self: @TContractState) -> u64;
}

#[starknet::contract]
mod SimpleStorage {
    use starknet::get_caller_address;
    use starknet::ContractAddress;

    #[storage]
    struct Storage {
        numbers: LegacyMap::<ContractAddress, u64>
    }

    #[abi(embed_v0)]
    impl SimpleStorage of super::ISimpleStorage<ContractState> {
        fn set_number(ref self: ContractState, number: u64) {
            let caller = get_caller_address();
            self.numbers.write(caller, number);
        }
        fn get_number(self: @ContractState) -> u64 {
            let caller = get_caller_address();
            return self.numbers.read(caller);
        }
    }
}

