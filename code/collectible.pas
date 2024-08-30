unit Collectible;

interface

uses Classes,CastleScene,CastleLog;

type
{Collectible that will trigger next levels}
TCollectible = class(TCastleScene)
private
    
public
    constructor Create(AOwner: TComponent); override;
    procedure PrintLog;
end;

implementation

constructor TCollectible.Create(AOwner: TComponent);
begin
    inherited;
end;

procedure TCollectible.PrintLog;
begin
    
    CastleLog.WritelnLog('Test')
end;

end.