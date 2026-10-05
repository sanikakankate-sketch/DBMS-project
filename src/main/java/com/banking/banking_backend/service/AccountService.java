package com.banking.banking_backend.service;

import com.banking.banking_backend.entity.Account;
import com.banking.banking_backend.repository.AccountRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AccountService {

    private final AccountRepository repository;

    public AccountService(AccountRepository repository) {
        this.repository = repository;
    }

    public List<Account> getAllAccounts() {
        return repository.findAll();
    }

    public Account getAccountById(Integer id) {
        return repository.findById(id).orElse(null);
    }

    public Account saveAccount(Account account) {
        return repository.save(account);
    }

    public void deleteAccount(Integer id) {
        repository.deleteById(id);
    }
}
