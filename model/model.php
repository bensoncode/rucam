<?
	// The application title is defined here 
	$application_title = "RUCAM System";
	
	// The application database and the connection string are defined here
	// syntax is: 'username@database.server/database_name IDENTIFIED BY PASSWORD ' 
	define('MYACTIVERECORD_CONNECTION_STR', 'mysql://root@localhost/rucam');
	
	// includes used implementation of MyActiveRecord class 
	include './include/MyActiveRecord.0.4.php';
	
	//in this array we list all and only those classes we like to CRUD manage from the main menu 
	$classes = array('teams','fixtures','competitors','cards');  
	
	// in this array we list all join tables which hold many to many relationships between two given classes of objects
	$join_tables = array('cards_fixtures');	
	
	// in this array below we list all foreign keys: this array MUST EXIST: if empty then uncomment line below (and comment the following one!)
	//foreign_keys=array();
	$foreign_keys = array('titles_id','teams_id','competitors_id','cardstatus_id','home_teams_id','away_teams_id','venues_id', 'cards_id', 'fixtures_id'); 

	/// TABLES ///
	define(T_TEAMS, "teams");
	define(T_FIXTURES, "fixtures");
	define(T_COMPETITORS, "competitors");
	define(T_CARDS, "cards");
	define(T_CARDSTATUS, "cardstatus");
	define(T_CARDS_FIXTURES, "cards_fixtures");
	/// CARD STATUSES ///
	define(CS_VALID, "Valid");
	define(CS_EXPIRED, "Expired");
	///

	$errMessages = array();
	
	// relationships between entities/classes are named below: if no name has
	// been given to a certain relationship, the bare foreign key would be displayed
	function name_child_relationship($class_name,$foreign_key)
	{
		if ($class_name == T_COMPETITORS && $foreign_key == 'titles_id')
		{
			return "Title";
		}
		else if ($class_name == T_COMPETITORS && $foreign_key == 'referred_as')
		{
			return "Name";
		}
		else if ($class_name == T_COMPETITORS && $foreign_key == 'teams_id')
		{
			return "Team";
		}
		else if ($class_name == T_CARDS && $foreign_key == 'competitors_id')
		{
			return "Competitor";
		}
		else if ($class_name == T_CARDS && $foreign_key == 'cardstatus_id')
		{
			return "Status";
		}
		else if ($class_name == T_FIXTURES && $foreign_key == 'home_teams_id')
		{
			return "Home Team";
		}
		else if ($class_name == T_FIXTURES && $foreign_key == 'away_teams_id')
		{
			return "Away Team";
		}
		else if ($class_name == T_FIXTURES && $foreign_key == 'venues_id')
		{
			return "Venue";
		}
	}

	// For displaying to the user only, define better names for each field or at least capitalise the words.
	function niceName($class_name, $field) {
		if (strlen($field) > 2 && !(strpos($field, '_id')===false))
		{
			// Is a foreign key so resolve with
			return name_child_relationship($class_name,$field);
		}

		// Not a foreign key so replace given field names with nicer names to display to the user.
		// If nothing has been defined just make sure the first letter is capitalised.
		switch ($field) {
			case "id":
				return "ID";
			case "controlledby":
				return "Controlled By";
			case "validfrom":
				return "Valid From";
			case "validuntil":
				return "Valid Until";
			case "checkin":
				return "Check In";
			case "checkout":
				return "Check Out";
			case "referred_as":
				if ($class_name == T_COMPETITORS) return "Name";
				if ($class_name == "teams") return "Nation";
			default:
				return ucfirst($field);
		}
	}

	// Remove the S from a word, if does not end in an s return the word back.
	function singularName($name, $ucfirst = false) 
	{
		// if ends in an s
		if (strlen($name) > 3 && strrpos(strtolower($name), "s") === strlen($name) - 1)
		{
			$name = substr($name, 0, -1);
		}
		if ($ucfirst) {
			$name = ucfirst($name);
		}
		return $name;
	}

	/**
	 * Defines a name for the joined table in this table.
	 * @param $thisTable The name of the current table
	 * @param $joinedTable The name of the table this table joins to.
	 */
	function joinName($thisTable, $joinedTable) {
		if ($thisTable == T_CARDS && $joinedTable == T_FIXTURES) return "Authorised Fixtures";
		if ($thisTable == T_FIXTURES && $joinedTable == T_CARDS) return "Authorised Cards";

		return $joinedTable;
	}

	/**
	 * Whether the refered_as field in a perticular table/class should be hidden from the user or not.
	 * @param $class The name of the class or table to check if the referred_as field should be hidden.
	 * @return True when the referred_as field should ne hidden and false if it should be shown.
	 */
	function hiddenReferredAs($class) {
		if ($class == T_FIXTURES) return true;
		if ($class == T_CARDS) return true;

		return false;
	}

	/**
	 * Define default foreign key values and whether they are disabled from editing.
	 * @param $mode Whether creating or updating.
	 * @param $class The name of the class being created or updated.
	 * @param $field The name of the field being created or updated.
	 * @return An array with the default id under the index 'id' and whether it 
	 *         should be disabled under the index 'disable'.
	 */
	function defaultForeignKey($mode, $class, $field) {
		if ($mode == "create" && $class == T_CARDS && $field == "cardstatus_id") return array("id" => 1, "disable" => true);;

		return null;
	}

	// this array has been initiated, but its usage will be defined in future versions of VF1
	$objects = array();
	
	// classes are defined below as extensions of MyActiveRecord class
	class competitors extends MyActiveRecord{
		function destroy(){
		}	
	}
		
	class teams extends MyActiveRecord{
		function destroy(){
		}	
	}
		
	class cards extends MyActiveRecord{
		function destroy(){
		}	
	}
		
	class fixtures extends MyActiveRecord{
		function destroy(){
		}	
	}
	
	class cards_fixtures extends MyActiveRecord{
		function destroy(){
		}	
	}
		
	class venues extends MyActiveRecord{
		function destroy(){
		}	
	}
		
	class titles extends MyActiveRecord{
		function destroy(){
		}	
	}
		
	class cardstatus extends MyActiveRecord{
		function destroy(){
		}	
	}

	/**
	 * Checks whether there are any errors.
	 * @param $errorArray The array holding the errors.
	 * @return True when there are errors, false when not.
	 */
	function hasErrors($errorArray) {
		return count($errorArray) > 0;
	}

	/**
	 * Checks whether a given card is valid or not. If a card is not valid and its status is
	 * still valid this will update the status to exired.
	 * @param $card The MyActiveRecord object for the card.
	 */
	function validCard($card) {
		
		$curdateInfo = getDate(time());
		$curdate = new DateTime("{$curdateInfo['year']}-{$curdateInfo['mon']}-{$curdateInfo['mday']}");
		$validuntildate = new DateTime($card->validuntil);
		$cardstatus = $card->find_parent(T_CARDSTATUS);
		if ($cardstatus->referred_as != CS_VALID || $curdate > $validuntildate) {
			// update the status to expired only if it was valid
			if ($cardstatus->referred_as == CS_VALID) {
				$card->cardstatus_id = MyActiveRecord::FindFirst(T_CARDSTATUS, "referred_as='".CS_EXPIRED."'")->id;
				$card->save();
			}
			return false;
		}
		return true;
	}
?>
