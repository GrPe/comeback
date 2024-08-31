unit Dangerous;

interface

uses Classes,
CastleScene, CastleTransform, CastleLog;

type
TDangerous = class(TCastleBehavior)
public
    StageNumber : integer;
public
    constructor Create(AOwner: TComponent); override;
    procedure SetNumber(CurrentInt : integer);
    procedure Update(const SecondsPassed: Single; var RemoveMe: TRemoveType); override;
end;    

implementation

constructor TDangerous.Create(AOwner: TComponent);
begin
    inherited;
end;

procedure TDangerous.Update(const SecondsPassed: Single; var RemoveMe: TRemoveType); 
begin
end;

procedure TDangerous.SetNumber(CurrentInt: integer);
begin
    StageNumber := CurrentInt;
end;

end.