package com.banking.banking_backend.service;

import com.banking.banking_backend.entity.Transaction;
import com.banking.banking_backend.repository.TransactionRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TransactionService {

    private final TransactionRepository repository;

    public TransactionService(TransactionRepository repository) {
        this.repository = repository;
    }

    public List<Transaction> getAllTransactions() {
        return repository.findAll();
    }

    public Transaction getTransactionById(Integer id) {
        return repository.findById(id).orElse(null);
    }

    public Transaction saveTransaction(Transaction transaction) {
        return repository.save(transaction);
    }

    public void deleteTransaction(Integer id) {
        repository.deleteById(id);
    }
}