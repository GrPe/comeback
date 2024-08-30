unit Collectible;

interface

uses Classes,
CastleScene, CastleTransform, CastleLog;


type
{Collectible that will trigger next levels}
TCollectible = class(TCastleScene)

strict private
    CollectibleBody : TCastleRigidBody;
  {  Collider : TCastleBoxCollider;}
public
    constructor Create(AOwner: TComponent); override;
    procedure Start;
    procedure PrintLog(const CollisionDetails: TPhysicsCollisionDetails);
end;

implementation

constructor TCollectible.Create(AOwner: TComponent);
begin
    inherited;
end;

procedure TCollectible.Start;
begin
    CollectibleBody := FindBehavior(TCastleRigidBody)  as TCastleRigidBody;
    CollectibleBody.OnCollisionEnter := {$ifdef FPC}@{$endif} PrintLog;
end;

procedure TCollectible.PrintLog(const CollisionDetails: TPhysicsCollisionDetails);
begin
    CastleLog.WritelnLog('Test')
end;

end.