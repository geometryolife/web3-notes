module MyAddr::MyCounter {
    use StarcoinFramework::Signer;

    struct Counter has key {
        value: u64
    }

    public fun init(account: &signer) {
        move_to(account, Counter { value: 0 });
    }

    public fun incr(account: &signer) acquires Counter {
        let addr = Signer::address_of(account);
        let counter = borrow_global_mut<Counter>(addr);
        counter.value = counter.value + 1;
    }

    public fun incr_by(account: &signer, increasement: u64) acquires Counter {
        let counter = borrow_global_mut<Counter>(Signer::address_of(account));
        counter.value = counter.value + increasement;
    }

    public fun get_value(account: &signer): u64 acquires Counter {
        let counter = borrow_global<Counter>(Signer::address_of(account));
        counter.value
    }

    // Define entry functions
    public(script) fun init_counter(account: signer) {
        Self::init(&account);
    }

    public(script) fun incr_counter(account: signer) acquires Counter {
        Self::incr(&account);
    }

    public(script) fun incr_counter_by(account: signer, increasement: u64) acquires Counter {
        Self::incr_by(&account, increasement);
    }
}