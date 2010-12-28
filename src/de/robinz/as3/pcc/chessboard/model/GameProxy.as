package de.robinz.as3.pcc.chessboard.model
{
	import de.robinz.as3.pcc.chessboard.ApplicationFacade;
	import de.robinz.as3.pcc.chessboard.library.ChessboardGame;
	import de.robinz.as3.pcc.chessboard.library.Notation;
	import de.robinz.as3.pcc.chessboard.library.notation.ChessboardMove;
	import de.robinz.as3.pcc.chessboard.library.pieces.Piece;

	import org.puremvc.as3.patterns.proxy.Proxy;

	/**
	 * GameProxy
	 *
	 * @author robin heinel
	 */
	public class GameProxy extends Proxy
	{
		public static const NAME : String = "GameProxy";

		private var _game : ChessboardGame;
		private var _currentMove : int;

		public function GameProxy( data : Object = null ) {
			super( NAME, data );
			this._game = new ChessboardGame();
			this._currentMove = 0;
		}

		// Start proxy overrides

		public override function getProxyName() : String {
			return NAME;
		}

		// End proxy overrides


		// Start Proxy Interface

		public function reset() : void {
			this._game = new ChessboardGame();
			this._currentMove = 0;
		}

		public function moveForward() : ChessboardMove {
			if ( this._currentMove >= this._game.moves.length ) {
				return null;
			}

			this._currentMove++;
			var move : ChessboardMove = this._game.moves.getAt( this._currentMove - 1 );
			return move;
		}

		public function moveBack() : ChessboardMove {
			if ( this._currentMove == 0 || this._game.moves.length == 0 ) {
				return null;
			}

			var move : ChessboardMove = this._game.moves.getAt( this._currentMove - 1 );
			this._currentMove--;
			return move;
		}

		public function move( m : ChessboardMove ) : void {
			if ( m.isMoveBack ) {
				return;
			}
			if ( m.isMoveForward ) {
				this._currentMove++;
				return;
			}

			this._currentMove++;
			this._game.moves.add( m );
		}

		public function getCurrentGame() : ChessboardGame {
			this._game.currentMove = this._currentMove;
			this._game.isLastMove = this._currentMove == this._game.moves.length
				? true
				: false;
			if ( this._game.moves.length > this._currentMove ) {
				this._game
			}
			return this._game;
		}

		public function setPiece( piece : String, shortenNotation : String, isWhite : Boolean ) : void {
			var m : ChessboardMove = new ChessboardMove();

			m.piece = Piece.createByParams( piece, isWhite );
			m.toPosition = Notation.createNotationByString( shortenNotation );

			sendNotification( ApplicationFacade.SET_PIECE, m );
		}

		// End Proxy Interface


		// Start Innerclass Methods

		// End Innerclass Methods


		// Start Getter / Setters

		public function get currentMove() : int {
			return this._currentMove;
		}

		// End Getter / Setters
	}
}