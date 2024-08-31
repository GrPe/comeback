unit PlayerManager;

interface

uses Classes,
  CastleComponentSerialize, CastleUIControls, CastleControls,
  CastleKeysMouse, CastleViewport, CastleScene, CastleVectors,
  CastleLog, sysutils, CastleTransform, GameState, CastleRenderOptions;

type
    TPlayerManager = class(TCastleScene)
    private
        PlayerObject: TCastleScene;
        PlayerPath: array[0..10000] of TVector2;
        PathSprites: array[0..10000] of TCastleScene;
        PathIndex: integer;
        AutoPilot: Boolean;
        Iterator: integer;
        PathTemplate: TCastleScene;
        VP: TCastleViewport;
        GameMode: TGameMode;

        PlayerBody: TCastleRigidBody;
        TimeToMove: Single;
    public
        constructor Create(AOwner: TComponent; APlayerObject: TCastleScene; AVP: TCastleViewport; AGameMode: TGameMode);
        procedure Start;
        procedure HandleInput(const Events: TInputPressRelease);
        procedure MoveNext();
        procedure BackToStart();
        procedure StopPlayer();
        procedure HandleCollision(const CollisionDetails: TPhysicsCollisionDetails);
        procedure Update(const SecondsPassed: Single);
        procedure Restart();
end;


implementation

constructor TPlayerManager.Create(AOwner: TComponent; APlayerObject: TCastleScene; AVP: TCastleViewport; AGameMode: TGameMode);
begin
inherited Create(AOwner);
    PlayerObject := APlayerObject;
    PathIndex := 0;
    AutoPilot := false;
    Iterator :=0;
    VP:= AVP;
    GameMode := AGameMode;

    PathTemplate := TCastleScene.Create(Self);
    PathTemplate.Load('castle-data:/Ship/low_quality_dot.png');
end;

procedure TPlayerManager.Start;
begin
    PlayerBody := PlayerObject.FindBehavior(TCastleRigidBody)  as TCastleRigidBody;
    PlayerBody.OnCollisionEnter := {$ifdef FPC}@{$endif} HandleCollision;
end;

procedure TPlayerManager.HandleInput(const Events: TInputPressRelease);
const
    PlayerSpeed = 16;
var
    T, OldPosition: TVector2;
    PathInstance: TCastleScene;
begin

    if AutoPilot then
    begin 
        Exit();
    end;

    if TimeToMove > 0 then Exit();

    OldPosition := PlayerObject.TranslationXY;

    if Events.IsKey(keyW) then
    begin
        T := PlayerObject.TranslationXY;
        T.Y := T.Y + PlayerSpeed;
        PlayerObject.TranslationXY := T;
    end

    else if Events.IsKey(KeyS) then
    begin
        T := PlayerObject.TranslationXY;
        T.Y := T.Y - PlayerSpeed;
        PlayerObject.TranslationXY := T;
    end

    else if Events.IsKey(KeyA) then
    begin
        T := PlayerObject.TranslationXY;
        T.X := T.X - PlayerSpeed;
        PlayerObject.TranslationXY := T;
    end

    else if Events.IsKey(KeyD) then
    begin
        T := PlayerObject.TranslationXY;
        T.X := T.X + PlayerSpeed;
        PlayerObject.TranslationXY := T;
    end

    else if Events.IsKey(KeyP) then
    begin
        StopPlayer();
        BackToStart();
        Exit();
    end

    else 
    begin
        Exit();
    end;

    PlayerPath[PathIndex] := OldPosition;

    PathInstance := PathTemplate.Clone(Self);
    PathInstance.Translation := Vector3(0, 0, 2);
    PathInstance.Scale := Vector3(1, 1, 1);
    PathInstance.TranslationXY := PlayerPath[PathIndex];
    PathInstance.RenderOptions.MagnificationFilter := magNearest;
    PathInstance.RenderOptions.MinificationFilter := minNearest;
    PathInstance.RenderLayer := rlFront;
    VP.Items.Add(PathInstance);
    PathSprites[PathIndex] := PathInstance;

    PathIndex := PathIndex + 1;

    TimeToMove := 0.3;
end;

procedure TPlayerManager.StopPlayer();
var 
    i: integer;
begin
    AutoPilot := true;
    Iterator := 0;

    for i:= 0 to PathIndex do
    begin
        FreeAndNil(PathSprites[i]);
    end;
end;

procedure TPlayerManager.MoveNext();
begin
    if AutoPilot = false then Exit();
    if Iterator >= PathIndex then Exit();
    
    PlayerObject.TranslationXY := PlayerPath[Iterator];
    Iterator := Iterator + 1;
end;

procedure TPlayerManager.BackToStart();
begin
    Iterator := 0;
    PlayerObject.TranslationXY := PlayerPath[Iterator];
end;

procedure TPlayerManager.Restart();
begin;
    BackToStart();
    AutoPilot := false;
    PathIndex := 0;
end;

procedure TPlayerManager.HandleCollision(const CollisionDetails: TPhysicsCollisionDetails);
var 
    CollidedObject: TCastleTransform;
begin
    CollidedObject := CollisionDetails.OtherTransform();
    CastleLog.WritelnLog(CollidedObject.Name);

    // Collectible 
    if CollidedObject.Name = 'Collectible' then
    begin
        if AutoPilot = false then
        begin
            PlayerPath[PathIndex] := PlayerObject.TranslationXY;
            PathIndex := PathIndex + 1;
        end;
        StopPlayer();
        BackToStart();
        GameMode.IncrementLevel();
        Exit();
    end;

    // Bad things
    if AutoPilot then
    begin
        CastleLog.WritelnLog('YOU DIED');
        Restart();
        GameMode.Restart();
        Exit();
    end;

    // You shall not pass
    PathIndex := PathIndex - 1;    
    PlayerObject.TranslationXY := PlayerPath[PathIndex];
    FreeAndNil(PathSprites[PathIndex]);
end;

procedure TPlayerManager.Update(const SecondsPassed: Single);
begin
    TimeToMove := TimeToMove - SecondsPassed;
end;

end.