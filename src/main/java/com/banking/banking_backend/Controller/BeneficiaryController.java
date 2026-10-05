package com.banking.banking_backend.Controller;

import com.banking.banking_backend.entity.Beneficiary;
import com.banking.banking_backend.service.BeneficiaryService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/beneficiaries")
@CrossOrigin(origins = "*")
public class BeneficiaryController {

    private final BeneficiaryService service;

    public BeneficiaryController(BeneficiaryService service) {
        this.service = service;
    }

    @GetMapping
    public List<Beneficiary> getAllBeneficiaries() {
        return service.getAllBeneficiaries();
    }

    @GetMapping("/{id}")
    public Beneficiary getBeneficiary(@PathVariable Integer id) {
        return service.getBeneficiaryById(id);
    }

    @PostMapping
    public Beneficiary addBeneficiary(@RequestBody Beneficiary beneficiary) {
        return service.saveBeneficiary(beneficiary);
    }

    @DeleteMapping("/{id}")
    public void deleteBeneficiary(@PathVariable Integer id) {
        service.deleteBeneficiary(id);
    }
}