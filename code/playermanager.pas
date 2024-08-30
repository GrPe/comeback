unit PlayerManager;

interface

uses Classes,
  CastleComponentSerialize, CastleUIControls, CastleControls,
  CastleKeysMouse, CastleViewport, CastleScene, CastleVectors;

type
    TPlayerManager = class(TCastleUserInterface)
    private
        PlayerObject: TCastleScene;
    public
        constructor Create(AOwner: TComponent; APlayerObject: TCastleScene);
        procedure HandleInput(const Event: TInputPressRelease);

end;


implementation

constructor TPlayerManager.Create(AOwner: TComponent; APlayerObject: TCastleScene);
begin
inherited Create(AOwner);
PlayerObject := APlayerObject;
end;

procedure TPlayerManager.HandleInput(const Event: TInputPressRelease);
const
    PlayerSpeed = 30;
var
    T: TVector2;
begin
    if Event.IsKey(keyW) then
    begin
        T := PlayerObject.TranslationXY;
        T.Y := T.Y + PlayerSpeed;
        PlayerObject.TranslationXY := T;
        Exit();
    end;

    if Event.IsKey(KeyS) then
    begin
        T := PlayerObject.TranslationXY;
        T.Y := T.Y - PlayerSpeed;
        PlayerObject.TranslationXY := T;
        Exit();
    end;

    if Event.IsKey(KeyA) then
    begin
        T := PlayerObject.TranslationXY;
        T.X := T.X - PlayerSpeed;
        PlayerObject.TranslationXY := T;
        Exit();
    end;

    if Event.IsKey(KeyD) then
    begin
        T := PlayerObject.TranslationXY;
        T.X := T.X + PlayerSpeed;
        PlayerObject.TranslationXY := T;
        Exit()
    end;

end;


end.