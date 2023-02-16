package ma.crudapp.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@EqualsAndHashCode
public class TransactionDTO {
    private Long id;
    private String title;
    private String description;
    private String type;
    private String category;
    private Integer sum;
    private String date;
}
