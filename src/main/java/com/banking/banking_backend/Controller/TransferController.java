package com.banking.banking_backend.Controller;

import com.banking.banking_backend.entity.Transfer;
import com.banking.banking_backend.service.TransferService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/transfers")
@CrossOrigin(origins = "*")
public class TransferController {

    private final TransferService service;

    public TransferController(TransferService service) {
        this.service = service;
    }

    @GetMapping
    public List<Transfer> getAllTransfers() {
        return service.getAllTransfers();
    }

    @GetMapping("/{id}")
    public Transfer getTransfer(@PathVariable Integer id) {
        return service.getTransferById(id);
    }

    @PostMapping
    public Transfer addTransfer(@RequestBody Transfer transfer) {
        return service.saveTransfer(transfer);
    }

    @DeleteMapping("/{id}")
    public void deleteTransfer(@PathVariable Integer id) {
        service.deleteTransfer(id);
    }
}