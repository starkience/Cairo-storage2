## Updated Contract: Enhanced SimpleStorage
Overview:
Key Changes:
- **Data Type:** Switched from `u128` to `felt252`
- **Storage Mechanism:** added a `LegacyMap` to associate numbers with addresses
- **Address Association:** with `get_caller_address()` 
- **Function Renaming:** from `set` and `get` to `set_number` and `get_number`
- **Functionality Update:** updated `get_number` function so users can retrieve their specific stored number

## Explanation:

### Interface (ISimpleStorage)

#### Functions

- `set_number(ref self: TContractState, number: felt252)`: we changed the data type to felt252
- `get_number(self: @TContractState) -> felt252`: we also changed to a felt252 data type
### Contract Implementation (SimpleStorage)

#### Storage

- **LegacyMap<ContractAddress, felt252> named numbers**: the contract can now store a separate `felt252` value for each user (address)

#### Functions (external)

- **set_number**: use `get_caller_address()` to link the number with the caller's address. This is now a multi-user, address-specific storage system
- **get_number**: gets the number associated with the caller's address

#### Why These Changes?

- write this section still !
