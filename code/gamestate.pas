unit Core;

interface
uses Classes,
CastleScene, CastleTransform, CastleLog;

type
TLevelStateBehavior = class(TCastleBehavior)

published
    ObjectTransforms: array of TCastleTransform
public
    constructor Create(AOwner: TComponent); override;
    procedure Start;
    procedure ProcessStep(const CollisionDetails: TPhysicsCollisionDetails);
end;    

implementation


uses CastleComponentSerialize;


initialization
  RegisterSerializableComponent(TLevelStateBehavior, 'Level State Tracker');
end.