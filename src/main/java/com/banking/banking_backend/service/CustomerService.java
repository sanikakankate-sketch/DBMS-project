package com.banking.banking_backend.service;



import com.banking.banking_backend.entity.Customer;
import com.banking.banking_backend.repository.CustomerRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerService {

    private final CustomerRepository repository;

    public CustomerService(CustomerRepository repository) {
        this.repository = repository;
    }

    public List<Customer> getAllCustomers() {
        return repository.findAll();
    }

    public Customer getCustomerById(Integer id) {
        return repository.findById(id).orElse(null);
    }

    public Customer saveCustomer(Customer customer) {
        return repository.save(customer);
    }

    public void deleteCustomer(Integer id) {
        repository.deleteById(id);
    }
}