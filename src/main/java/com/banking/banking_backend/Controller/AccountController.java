package com.banking.banking_backend.Controller;


import com.banking.banking_backend.entity.Account;
import com.banking.banking_backend.service.AccountService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/accounts")
@CrossOrigin(origins = "*")
public class AccountController {

    private final AccountService service;

    public AccountController(AccountService service) {
        this.service = service;
    }

    @GetMapping
    public List<Account> getAllAccounts() {
        return service.getAllAccounts();
    }

    @GetMapping("/{id}")
    public Account getAccount(@PathVariable Integer id) {
        return service.getAccountById(id);
    }

    @PostMapping
    public Account addAccount(@RequestBody Account account) {
        return service.saveAccount(account);
    }

    @DeleteMapping("/{id}")
    public void deleteAccount(@PathVariable Integer id) {
        service.deleteAccount(id);
    }
}