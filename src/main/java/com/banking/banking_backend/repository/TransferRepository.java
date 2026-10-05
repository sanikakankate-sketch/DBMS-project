package com.banking.banking_backend.repository;

import com.banking.banking_backend.entity.Transfer;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TransferRepository extends JpaRepository<Transfer, Integer> {
}