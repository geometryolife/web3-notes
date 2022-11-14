module MyAddr::MyLibrary {
    use StarcoinFramework::Signer;
    use StarcoinFramework::Vector;

    // struct Book has store, copy, drop {
    struct Book has drop, store {
        id: u64,
        name: vector<u8>,
        link: vector<u8>,
    }

    struct Library has key {
        books: vector<Book>
    }

    public fun create_library(account: &signer) {
        let books = Vector::empty<Book>();
        move_to(account, Library { books });
    }

    // Because the script function cannot have return value,
    // query only can be done by: state get resource Address Address::Module::Resource
    public fun add_book(account: &signer, name: vector<u8>, link: vector<u8>) acquires Library {
        let lib = borrow_global_mut<Library>(Signer::address_of(account));
        let id = Vector::length(&lib.books);
        Vector::push_back(&mut lib.books, Book { id, name, link });
    }

    public fun update_book_at_id(account: &signer, id: u64, name: vector<u8>, link: vector<u8>) acquires Library {
        let lib = borrow_global_mut<Library>(Signer::address_of(account));
        let book = Vector::borrow_mut<Book>(&mut lib.books, id);
        book.name = name;
        book.link = link;
    }

    public fun delete_book_at_id(account: &signer, id: u64) acquires Library {
        let lib = borrow_global_mut<Library>(Signer::address_of(account));
        Vector::remove<Book>(&mut lib.books, id);
    }

    public(script) fun init_library(account: signer) {
        Self::create_library(&account);
    }

    public(script) fun s_add_book(account: signer, name: vector<u8>, link: vector<u8>) acquires Library {
        Self::add_book(&account, name, link);
    }

    public(script) fun s_update_book_at_id(account: signer, id: u64, name: vector<u8>, link: vector<u8>) acquires Library {
        update_book_at_id(&account, id, name, link);
    }

    public(script) fun s_delete_book_at_id(account: signer, id: u64) acquires Library {
        Self::delete_book_at_id(&account, id);
    }
}