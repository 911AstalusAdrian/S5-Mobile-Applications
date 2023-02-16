package ma.crudapp.converter;

public interface ConverterInterface<Model, Dto>{
    Model DtoToModel(Dto dto);

    Dto ModelToDto(Model model);
}
