package com.banking.banking_backend.repository;



import com.banking.banking_backend.entity.BankBranch;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BankBranchRepository extends JpaRepository<BankBranch, Integer> {
}