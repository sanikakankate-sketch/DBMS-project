package com.banking.banking_backend.service;

import com.banking.banking_backend.entity.Beneficiary;
import com.banking.banking_backend.repository.BeneficiaryRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BeneficiaryService {

    private final BeneficiaryRepository repository;

    public BeneficiaryService(BeneficiaryRepository repository) {
        this.repository = repository;
    }

    public List<Beneficiary> getAllBeneficiaries() {
        return repository.findAll();
    }

    public Beneficiary getBeneficiaryById(Integer id) {
        return repository.findById(id).orElse(null);
    }

    public Beneficiary saveBeneficiary(Beneficiary beneficiary) {
        return repository.save(beneficiary);
    }

    public void deleteBeneficiary(Integer id) {
        repository.deleteById(id);
    }
}