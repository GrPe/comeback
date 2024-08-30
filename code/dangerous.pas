unit Core;

interface

uses Classes,
CastleScene, CastleTransform, CastleLog;

type
TDangerous = class(TCastleBehaviour)
public
    constructor Create(AOwner: TComponent); override;
end;    

implementation

constructor TCollectible.Create(AOwner: TComponent);
begin
    inherited;
end;

end.