package com.banking.banking_backend.Controller;


import com.banking.banking_backend.entity.BankBranch;
import com.banking.banking_backend.service.BranchService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/branches")
@CrossOrigin(origins = "*")
public class BranchController {

    private final BranchService service;

    public BranchController(BranchService service) {
        this.service = service;
    }

    @GetMapping
    public List<BankBranch> getAllBranches() {
        return service.getAllBranches();
    }

    @GetMapping("/{id}")
    public BankBranch getBranch(@PathVariable Integer id) {
        return service.getBranchById(id);
    }

    @PostMapping
    public BankBranch addBranch(@RequestBody BankBranch branch) {
        return service.saveBranch(branch);
    }

    @DeleteMapping("/{id}")
    public void deleteBranch(@PathVariable Integer id) {
        service.deleteBranch(id);
    }
}