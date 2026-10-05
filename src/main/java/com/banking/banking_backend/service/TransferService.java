package com.banking.banking_backend.service;

import com.banking.banking_backend.entity.Transfer;
import com.banking.banking_backend.repository.TransferRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TransferService {

    private final TransferRepository repository;

    public TransferService(TransferRepository repository) {
        this.repository = repository;
    }

    public List<Transfer> getAllTransfers() {
        return repository.findAll();
    }

    public Transfer getTransferById(Integer id) {
        return repository.findById(id).orElse(null);
    }

    public Transfer saveTransfer(Transfer transfer) {
        return repository.save(transfer);
    }

    public void deleteTransfer(Integer id) {
        repository.deleteById(id);
    }
}