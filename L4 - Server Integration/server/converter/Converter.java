package ma.crudapp.converter;

import ma.crudapp.dto.TransactionDTO;
import ma.crudapp.model.Transaction;
import org.springframework.stereotype.Component;

import java.util.Collection;
import java.util.Set;
import java.util.stream.Collectors;

@Component
public class Converter implements ConverterInterface<Transaction, TransactionDTO> {

    public Set<Long> ModelsToIDs(Set<Transaction> models){
        return models.stream()
                .map(Transaction::getId)// model -> model.getId() in map
                .collect(Collectors.toSet());
    }

    public Set<Long> DtosToIDs(Set<TransactionDTO> dtos){
        return dtos.stream()
                .map(TransactionDTO::getId) // dto -> dto.getId() in map
                .collect(Collectors.toSet());
    }

    public Set<TransactionDTO> ModelsToDtos(Collection<Transaction> models){
        return models.stream()
                .map(this::ModelToDto)// model -> ModelToDto(model)
                .collect(Collectors.toSet());
    }

    public Set<Transaction> DtosToModels(Collection<TransactionDTO> dtos){
        return dtos.stream()
                .map(this::DtoToModel)
                .collect(Collectors.toSet());
    }

    @Override
    public Transaction DtoToModel(TransactionDTO transactionDTO) {
        Transaction transaction = new Transaction(transactionDTO.getId(),
                transactionDTO.getTitle(),
                transactionDTO.getDescription(),
                transactionDTO.getType(),
                transactionDTO.getCategory(),
                transactionDTO.getSum(),
                transactionDTO.getDate());

        return transaction;
    }

    @Override
    public TransactionDTO ModelToDto(Transaction transaction) {
        TransactionDTO dto = new TransactionDTO(transaction.getId(),
                transaction.getTitle(),
                transaction.getDescription(),
                transaction.getType(),
                transaction.getCategory(),
                transaction.getSum(),
                transaction.getDate());

        return dto;
    }
}
