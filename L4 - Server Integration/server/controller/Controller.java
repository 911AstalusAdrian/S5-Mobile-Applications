package ma.crudapp.controller;

import ma.crudapp.converter.Converter;
import ma.crudapp.dto.TransactionDTO;
import ma.crudapp.model.Transaction;
import ma.crudapp.repository.TransactionRepo;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;
import java.util.Set;

@RestController
public class Controller {

    private TransactionRepo repo;
    private Converter converter;

    public Controller(TransactionRepo repo, Converter converter){
        this.repo = repo;
        this.converter = converter;
    }

    @GetMapping("/transactions")
    public Set<TransactionDTO> getAllTransactions(){
        System.out.println("--- all transactions ---");
        return converter.ModelsToDtos(repo.findAll());
    }

    @PostMapping("/transactions")
    public Transaction addTransaction(@RequestBody Transaction tran){
        System.out.println("--- add transaction ---");
        return repo.save(tran);
    }

    @DeleteMapping("/transactions/{id}")
    public Transaction deleteTransaction(@PathVariable long id){
        System.out.println("--- delete transaction ---");
        Optional<Transaction> tranOptional = repo.findById(id);

        if(tranOptional.isEmpty()){
            return null;
        }

        repo.deleteById(id);
        return tranOptional.get();
    }

    @PutMapping("/transactions/{id}")
    public Transaction updateTransaction(@PathVariable long id, @RequestBody Transaction tran){
        System.out.println("--- update transaction ---");
        Optional<Transaction> tranOptional = repo.findById(id);

        if (tranOptional.isEmpty()){
            return null;
        }

        tran.setId(id);
        return repo.save(tran);
    }
}
