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
        PathIndex: integer;
        ComponentsFactory: TCastleComponentFactory;
    public
        constructor Create(AOwner: TComponent; APlayerObject: TCastleScene);
        procedure HandleInput(const Event: TInputPressRelease; VP: TCastleViewport);

end;


implementation

constructor TPlayerManager.Create(AOwner: TComponent; APlayerObject: TCastleScene);
begin
inherited Create(AOwner);
PlayerObject := APlayerObject;
PathIndex := 0;
end;

procedure TPlayerManager.HandleInput(const Event: TInputPressRelease; VP: TCastleViewport);
const
    PlayerSpeed = 45;
var
    T, OldPosition: TVector2;
    i :integer;
    PathTemplate, PathInstance: TCastleScene;
begin
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
    
        PathTemplate:= TCastleScene.Create(Self);
        PathTemplate.Load('castle-data:/spritesheets/disciple.castle-sprite-sheet');
        for i:=0 to PathIndex do
            begin
            PathInstance := PathTemplate.Clone(Self);
            PathInstance.Translation := Vector3(0, 0, 2);
            PathInstance.Scale := Vector3(3, 3, 3);
            PathInstance.TranslationXY := PlayerPath[i];
            VP.Items.Add(PathInstance);
            end;
        Exit();
    end

    else 
    begin
        Exit();
    end;

    PlayerPath[PathIndex] := OldPosition;
    PathIndex := PathIndex + 1;
end;


end.