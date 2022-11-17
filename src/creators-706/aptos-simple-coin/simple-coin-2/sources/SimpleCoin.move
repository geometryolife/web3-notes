module my_address::SimpleCoin2 {
    use aptos_framework::coin::{Self, MintCapability, BurnCapability};
    use std::signer::address_of;
    use std::string;
    #[test_only]
    use aptos_framework::account::create_account_for_test;
    #[test_only]
    use std::option;

    struct USDC {}

    struct Cap<phantom CoinType> has key {
        mint: MintCapability<USDC>,
        burn: BurnCapability<USDC>,
    }

    public entry fun issue(sender: &signer) acquires Cap {
        let (b_cap, f_cap, m_cap) = coin::initialize<USDC>(
            sender,
            string::utf8(b"USDC"),
            string::utf8(b"USDC"),
            8,
            true
        );

        coin::destroy_freeze_cap(f_cap);
        move_to(sender, Cap<USDC> {
            mint: m_cap,
            burn: b_cap
        });

        coin::register<USDC>(sender);

        let cap = borrow_global_mut<Cap<USDC>>(address_of(sender));
        let mint_usdc = coin::mint(1000000000, &cap.mint);
        coin::deposit(address_of(sender),mint_usdc);
    }

    public entry fun register(sender: &signer) {
        coin::register<USDC>(sender);
    }

    #[test(sender = @my_address,receiver= @receiver)]
    fun issue_should_work(sender: &signer, receiver: &signer) acquires Cap {
        create_account_for_test(@my_address);
        create_account_for_test(@receiver);
        issue(sender);

        assert!(coin::name<USDC>() == string::utf8(b"USDC"), 0);
        assert!(coin::symbol<USDC>() == string::utf8(b"USDC"), 0);

        assert!(coin::supply<USDC>() == option::some(1000000000), 0);
        assert!(coin::balance<USDC>(@my_address) == 1000000000, 0);

        register(receiver);
        coin::transfer<USDC>(sender, @receiver, 100000000);

        assert!(coin::balance<USDC>(@my_address) == 900000000, 0);
        assert!(coin::balance<USDC>(@receiver) == 100000000, 0);
    }
}