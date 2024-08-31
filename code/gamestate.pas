unit GameState;

interface
uses Classes,
CastleScene, CastleTransform, CastleLog, Dangerous, SysUtils;

type
TGameMode = class(TCastleScene)

strict private
    DangerousObjects: array[0..1000] of TDangerous;
    DangerousObjectsIndex : integer;

    CurrentLevelIndex : integer;
public
    constructor Create(AOwner: TComponent); override;
    procedure Start;
    procedure IncrementLevel();
    procedure TurnOnWithNumber(NumberToTurn : integer);
    procedure Restart();
end;    

implementation
constructor TGameMode.Create(AOwner: TComponent);
begin
    inherited
end;

procedure TGameMode.Start;
var 
    I : integer;
    ItemsCount : integer;
    CurrentDangerous : TDangerous;
    CurrentName : string;

begin
    ItemsCount := Count() - 1;
    DangerousObjectsIndex := -1;
    CurrentLevelIndex := -1;
end;

procedure TGameMode.TurnOnWithNumber(NumberToTurn : integer);
var 
    I : integer;
    AsScene : TCastleScene;
begin   
    for I := 0 to Count() - 1 do
    begin
    if StrToInt(RightStr(Items[I].Name, 1)) <= NumberToTurn then
        begin
        if Items[I].Exists = false then
        Items[I].Exists := true;
        end else
        begin
        if Items[I].Exists = true then
        Items[I].Exists := false;
        end;
    end;
end;

procedure TGameMode.IncrementLevel();
begin
    CurrentLevelIndex := CurrentLevelIndex + 1;
    TurnOnWithNumber(CurrentLevelIndex);
end;

procedure TGameMode.Restart();
begin
    CurrentLevelIndex := -1;
    TurnOnWithNumber(CurrentLevelIndex);
end;

end.