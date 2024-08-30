unit PlayerManager;

interface

uses Classes,
  CastleComponentSerialize, CastleUIControls, CastleControls,
  CastleKeysMouse, CastleViewport, CastleScene, CastleVectors,
  CastleLog, sysutils;

type
    TPlayerManager = class(TCastleUserInterface)
    private
        PlayerObject: TCastleScene;
        PlayerPath: array[0..10000] of TVector2;
        PathSprites: array[0..10000] of TCastleScene;
        PathIndex: integer;
        AutoPilot: Boolean;
        Iterator: integer;
        PathTemplate: TCastleScene;
        VP: TCastleViewport;
    public
        constructor Create(AOwner: TComponent; APlayerObject: TCastleScene; AVP: TCastleViewport);
        procedure HandleInput(const Event: TInputPressRelease);
        procedure MoveNext();
        procedure BackToStart();
        procedure StopPlayer();
end;


implementation

constructor TPlayerManager.Create(AOwner: TComponent; APlayerObject: TCastleScene; AVP: TCastleViewport);
begin
inherited Create(AOwner);
    PlayerObject := APlayerObject;
    PathIndex := 0;
    AutoPilot := false;
    Iterator :=0;
    VP:= AVP;

    PathTemplate := TCastleScene.Create(Self);
    PathTemplate.Load('castle-data:/Ship/stateczek.png');
end;

procedure TPlayerManager.HandleInput(const Event: TInputPressRelease);
const
    PlayerSpeed = 32;
var
    T, OldPosition: TVector2;
    PathInstance: TCastleScene;
begin

    if AutoPilot then
    begin 
        Exit();
    end;

    OldPosition := PlayerObject.TranslationXY;

    if Event.IsKey(keyW) then
    begin
        T := PlayerObject.TranslationXY;
        T.Y := T.Y + PlayerSpeed;
        PlayerObject.TranslationXY := T;
    end

    else if Event.IsKey(KeyS) then
    begin
        T := PlayerObject.TranslationXY;
        T.Y := T.Y - PlayerSpeed;
        PlayerObject.TranslationXY := T;
    end

    else if Event.IsKey(KeyA) then
    begin
        T := PlayerObject.TranslationXY;
        T.X := T.X - PlayerSpeed;
        PlayerObject.TranslationXY := T;
    end

    else if Event.IsKey(KeyD) then
    begin
        T := PlayerObject.TranslationXY;
        T.X := T.X + PlayerSpeed;
        PlayerObject.TranslationXY := T;
    end

    else if Event.IsKey(KeyP) then
    begin
    
        // PathTemplate:= TCastleScene.Create(Self);
        // PathTemplate.Load('castle-data:/Ship/stateczek.png');
        // for i:=0 to PathIndex do
        //     begin
        //     PathInstance := PathTemplate.Clone(Self);
        //     PathInstance.Translation := Vector3(0, 0, 2);
        //     PathInstance.Scale := Vector3(1, 1, 1);
        //     PathInstance.TranslationXY := PlayerPath[i];
        //     VP.Items.Add(PathInstance);
        //     end;

        
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
    VP.Items.Add(PathInstance);
    PathSprites[PathIndex] := PathInstance;

    PathIndex := PathIndex + 1;
end;

procedure TPlayerManager.StopPlayer();
var 
    i: integer;
begin
    AutoPilot := true;
    Iterator := 0;

    for i:= 0 to PathIndex do
    begin
        VP.Items.Remove(PathSprites[i]);
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

end.