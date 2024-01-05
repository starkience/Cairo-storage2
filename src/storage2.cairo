// given the anatomy of a Cairo smart contract, let's now see what can add
// Along these turorials, we'll be adding variables of different types, functions and attributes necessary to make the contract more functional

// looking back at our storage1 contract:
// we changed the data type from u128 to felt252
// we introduced a map to store numbers each associated woth a different address
// we introduced get_caller_address() to associate values with caller addresses
// we renamed 'set' to 'set_number' and 'get' to 'get_number'
// we modified the implementation of our 'get_number' function to allows a user to retrieve the number they have stored in the contract.

#[starknet::interface]
trait ISimpleStorage<TContractState> {
    fn set_number(ref self: TContractState, number: felt252);
    fn get_number(self: @TContractState) -> felt252;
}

#[starknet::contract]
mod SimpleStorage {
    use starknet::get_caller_address;
    use starknet::ContractAddress;

    #[storage]
    struct Storage {
        numbers: LegacyMap<ContractAddress, felt252>
    }

    #[abi(embed_v0)]
    impl SimpleStorage of super::ISimpleStorage<ContractState> {
        fn set_number(ref self: ContractState, number: felt252) {
            let caller = get_caller_address();
            self.numbers.write(caller, number);
        }
        fn get_number(self: @ContractState) -> felt252 {
            let caller = get_caller_address();
            return self.numbers.read(caller);
        }
    }
}