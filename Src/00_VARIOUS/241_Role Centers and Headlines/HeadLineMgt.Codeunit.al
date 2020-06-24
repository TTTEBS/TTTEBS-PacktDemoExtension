codeunit 50110 "TTTEBS HeadLineMgt"
{
    procedure Qualifier(pText: Text) :Text
    begin
        exit('<qualifier>'+ pText +'</qualifier>');        
    end;
    
    procedure Payload(pText: Text) :Text
    begin
        exit('<payload>'+ pText +'</payload>');        
    end;
    
    procedure Emphasize(pText: Text) :Text
    begin
        exit('<emphasize>'+ pText +'</emphasize>');        
    end;
}