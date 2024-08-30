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
end;    

implementation

constructor TDangerous.Create(AOwner: TComponent);
begin
    inherited;
end;

procedure TDangerous.SetNumber(CurrentInt: integer);
begin
    StageNumber := CurrentInt;
end;

end.