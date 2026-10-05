package com.banking.banking_backend.service;


import com.banking.banking_backend.entity.BankBranch;
import com.banking.banking_backend.repository.BankBranchRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BranchService {

    private final BankBranchRepository repository;

    public BranchService(BankBranchRepository repository) {
        this.repository = repository;
    }

    public List<BankBranch> getAllBranches() {
        return repository.findAll();
    }

    public BankBranch getBranchById(Integer id) {
        return repository.findById(id).orElse(null);
    }

    public BankBranch saveBranch(BankBranch branch) {
        return repository.save(branch);
    }

    public void deleteBranch(Integer id) {
        repository.deleteById(id);
    }
}