unit GameState;

interface
uses Classes,
CastleScene, CastleTransform, CastleLog, Dangerous, SysUtils;

type
TEnemyStateAssigner = class(TCastleScene)

strict private

public
    constructor Create(AOwner: TComponent); override;
    procedure Start;
end;    

implementation
constructor TEnemyStateAssigner.Create(AOwner: TComponent);
begin
    inherited
end;

procedure TEnemyStateAssigner.Start;
var 
    I : integer;
    ItemsCount : integer;
    LevelNumber : integer;
    CurrentDangerous : TDangerous;
    CurrentName : string;

begin
    ItemsCount := Count() - 1;

    for I := 0 to ItemsCount do
    begin
        CurrentDangerous := TDangerous.Create(Items[I]);
        Items[I].AddBehavior(CurrentDangerous);
        CurrentName := Copy(Items[I].Name,5,1);
        CurrentDangerous.SetNumber(StrToInt(CurrentName));
    end;
end;


end.