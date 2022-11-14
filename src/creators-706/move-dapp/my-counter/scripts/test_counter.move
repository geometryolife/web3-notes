script {
    use MyAddr::MyCounter;
    use StarcoinFramework::Debug;

    const ERR_NOT_OK: u64 = 100;

    fun test_counter(account: signer, incr_value: u64) {
        MyCounter::init(&account);
        MyCounter::incr(&account);
        MyCounter::incr(&account);
        MyCounter::incr_by(&account, incr_value);

        let val = MyCounter::get_value(&account);
        assert!(val == 5, ERR_NOT_OK);

        Debug::print(&val);
    }
}