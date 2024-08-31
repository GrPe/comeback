{ Main "playing game" view, where most of the game logic takes place.

  Feel free to use this code as a starting point for your own projects.
  This template code is in public domain, unlike most other CGE code which
  is covered by BSD or LGPL (see https://castle-engine.io/license). }
unit GameViewPlay;

interface

uses Classes,
  CastleComponentSerialize, CastleUIControls, CastleControls,
  CastleKeysMouse, CastleViewport, CastleScene, CastleVectors,
  PlayerManager,Collectible, GameState, CastleLog;


type
  { Main "playing game" view, where most of the game logic takes place. }
  TViewPlay = class(TCastleView)
  published

    MainViewport: TCastleViewport;
    PlayerCharacter : TCastleScene;
    Collectible : TCollectible;
    GameState : TGameMode;
  private
    PlayerManager: TPlayerManager;
    ElapsedSeconds: Single;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Start; override;
    procedure Update(const SecondsPassed: Single; var HandleInput: Boolean); override;
    function Press(const Event: TInputPressRelease): Boolean; override;
  end;

var
  ViewPlay: TViewPlay;

implementation

uses SysUtils, Math,
  GameViewMenu;

{ TViewPlay ----------------------------------------------------------------- }

constructor TViewPlay.Create(AOwner: TComponent);
begin
  inherited;
  DesignUrl := 'castle-data:/gameviewplay.castle-user-interface';
  ElapsedSeconds := 0.8;
end;

procedure TViewPlay.Start;
begin
  inherited;
  PlayerManager := TPlayerManager.Create(PlayerCharacter,PlayerCharacter,MainViewport,GameState);
  PlayerManager.Start();
 { Collectible.Start};
  GameState.Start();
  GameState.TurnOnWithNumber(-1);
end;

procedure TViewPlay.Update(const SecondsPassed: Single; var HandleInput: Boolean);
const
  DragonSpeed: TVector2 = (X: 3000; Y: 1500);
var
  T: TVector2;
  CamPos: TVector3;
begin
  inherited;

  PlayerManager.Update(SecondsPassed);
  ElapsedSeconds := ElapsedSeconds - SecondsPassed;

  if ElapsedSeconds > 0 then Exit();

  PlayerManager.MoveNext();
  ElapsedSeconds := 0.4;
end;

function TViewPlay.Press(const Event: TInputPressRelease): Boolean;
begin
  Result := inherited;
  if Result then Exit; // allow the ancestor to handle keys

  { This virtual method is executed when user presses
    a key, a mouse button, or touches a touch-screen.

    Note that each UI control has also events like OnPress and OnClick.
    These events can be used to handle the "press", if it should do something
    specific when used in that UI control.
    The TViewPlay.Press method should be used to handle keys
    not handled in children controls.
  }

  PlayerManager.HandleInput(Event);

  if Event.IsMouseButton(buttonLeft) then
  begin
  
    Exit(true); // click was handled
  end;

  if Event.IsKey(keyF5) then
  begin
    Container.SaveScreenToDefaultFile;
    Exit(true);
  end;

  if Event.IsKey(keyEscape) then
  begin
    Container.View := ViewMenu;
    Exit(true);
  end;
end;

end.
