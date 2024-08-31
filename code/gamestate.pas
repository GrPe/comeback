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

    for I := 0 to ItemsCount do
    begin
        CurrentDangerous := TDangerous.Create(Items[I]);
        Items[I].AddBehavior(CurrentDangerous);
        CurrentName := Copy(Items[I].Name,5,1);
        CurrentDangerous.SetNumber(StrToInt(CurrentName));

        DangerousObjectsIndex := DangerousObjectsIndex + 1;
        DangerousObjects[DangerousObjectsIndex] := CurrentDangerous;
    end;
end;

procedure TGameMode.TurnOnWithNumber(NumberToTurn : integer);
var 
    I : integer;
    AsScene : TCastleScene;
begin   
    for I := 0 to DangerousObjectsIndex do
    begin
    if DangerousObjects[I].StageNumber <= NumberToTurn then
        begin
        if DangerousObjects[I].Parent.Exists = false then
        DangerousObjects[I].Parent.Exists := true;
        AsScene := DangerousObjects[I].Parent as TCastleScene;
        end else
        begin
        if DangerousObjects[I].Parent.Exists = true then
        DangerousObjects[I].Parent.Exists := false;
        AsScene := DangerousObjects[I].Parent as TCastleScene;
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