<?php
/* Copyright (C) 2006-2012	Laurent Destailleur	<eldy@users.sourceforge.net>
 * Copyright (C) 2009-2012	Regis Houssin		<regis.houssin@inodbox.com>
 * Copyright (C) 2023		Charlene BENKE		<charlene@patas-monkey.com>
 * Copyright (C) 2024		MDW					<mdeweerd@users.noreply.github.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 * or see https://www.gnu.org/
 */

/**
 * \file       htdocs/core/lib/contract.lib.php
 * \brief      Ensemble de functions de base pour le module contract
 */

/**
 * Prepare array with list of tabs
 *
 * @param   Contract	$object		Object related to tabs
 * @return	array<array{0:string,1:string,2:string}>	Array of tabs to show
 */
function contract_prepare_head(Contract $object)
{
	global $db, $langs, $config, $user;

	$h = 0;
	$head = [];

	$head[$h][0] = DOL_URL_ROOT . '/contract/card.php?id=' . $object->id;
	$head[$h][1] = $langs->trans("ContractCard");
	$head[$h][2] = 'card';
	$h++;

	if (!getDolGlobalString('MAIN_DISABLE_CONTACTS_TAB')) {
		$nbContact = count($object->liste_contact(-1, 'internal')) + count($object->liste_contact(-1, 'external'));
		$head[$h][0] = DOL_URL_ROOT . '/contract/contact.php?id=' . $object->id;
		$head[$h][1] = $langs->trans("ContactsAddresses");
		if ($nbContact > 0) {
			$head[$h][1] .= '<span class="badge marginleftonlyshort">' . $nbContact . '</span>';
		}
		$head[$h][2] = 'contact';
		$h++;
	}

	/* deprecated. Contracts and tickets are already linked with the generic "Link to" feature */
	if (isModEnabled('ticket') && getDolGlobalString('TICKET_LINK_TO_CONTRACT_WITH_HARDLINK')) {
		$head[$h][0] = DOL_URL_ROOT . '/contract/ticket.php?id=' . $object->id;
		$head[$h][1] = $langs->trans("Tickets");
		$head[$h][2] = 'ticket';
		$h++;
	}

	// Show more tabs from modules
	// Entries must be declared in modules descriptor with line
	// $this->tabs = array('entity:+tabname:Title:@mymodule:/mymodule/mypage.php?id=__ID__');   to add new tab
	// $this->tabs = array('entity:-tabname);   												to remove a tab
	complete_head_from_modules($config, $langs, $object, $head, $h, 'contract', 'add', 'core');

	if (!getDolGlobalString('MAIN_DISABLE_NOTES_TAB')) {
		$nbNote = 0;
		if (!empty($object->note_private)) {
			$nbNote++;
		}
		if (!empty($object->note_public)) {
			$nbNote++;
		}
		$head[$h][0] = DOL_URL_ROOT . '/contract/note.php?id=' . $object->id;
		$head[$h][1] = $langs->trans("Notes");
		if ($nbNote > 0) {
			$head[$h][1] .= '<span class="badge marginleftonlyshort">' . $nbNote . '</span>';
		}
		$head[$h][2] = 'note';
		$h++;
	}

	require_once DOL_DOCUMENT_ROOT . '/core/lib/files.lib.php';
	require_once DOL_DOCUMENT_ROOT . '/core/class/link.class.php';
	$upload_dir = $config->contract->multidir_output[$object->entity] . "/" . dol_sanitizeFileName($object->ref);
	$nbFiles = count(dol_dir_list($upload_dir, 'files', 0, '', '(\.meta|_preview.*\.png)$'));
	$nbLinks = Link::count($db, $object->element, $object->id);
	$head[$h][0] = DOL_URL_ROOT . '/contract/document.php?id=' . $object->id;
	$head[$h][1] = $langs->trans("Documents");
	if (($nbFiles + $nbLinks) > 0) {
		$head[$h][1] .= '<span class="badge marginleftonlyshort">' . ($nbFiles + $nbLinks) . '</span>';
	}
	$head[$h][2] = 'documents';
	$h++;


	$head[$h][0] = DOL_URL_ROOT . '/contract/agenda.php?id=' . $object->id;
	$head[$h][1] = $langs->trans("Events");
	if (isModEnabled('agenda') && ($user->hasRight('agenda', 'myactions', 'read') || $user->hasRight('agenda', 'allactions', 'read'))) {
		$nbEvent = 0;
		// Enable caching of thirdparty count actioncomm
		require_once DOL_DOCUMENT_ROOT . '/core/lib/memory.lib.php';
		$cachekey = 'count_events_contract_' . $object->id;
		$dataretrieved = dol_getcache($cachekey);
		if (!is_null($dataretrieved)) {
			$nbEvent = $dataretrieved;
		} else {
			$sql = "SELECT COUNT(id) as nb";
			$sql .= " FROM " . MAIN_DB_PREFIX . "actioncomm";
			$sql .= " WHERE fk_element = " . ((int) $object->id);
			$sql .= " AND elementtype = 'contract'";
			$resql = $db->query($sql);
			if ($resql) {
				$obj = $db->fetch_object($resql);
				$nbEvent = $obj->nb;
			} else {
				dol_syslog('Failed to count actioncomm ' . $db->lasterror(), LOG_ERR);
			}
			dol_setcache($cachekey, $nbEvent, 120);		// If setting cache fails, this is not a problem, so we do not test result.
		}

		$head[$h][1] .= '/';
		$head[$h][1] .= $langs->trans("Agenda");
		if ($nbEvent > 0) {
			$head[$h][1] .= '<span class="badge marginleftonlyshort">' . $nbEvent . '</span>';
		}
	}
	$head[$h][2] = 'agenda';
	$h++;

	complete_head_from_modules($config, $langs, $object, $head, $h, 'contract', 'add', 'external');

	complete_head_from_modules($config, $langs, $object, $head, $h, 'contract', 'remove');

	return $head;
}

/**
 *  Return array head with list of tabs to view object information.
 *
 * @return	array<array{0:string,1:string,2:string}>	Array of tabs to show
 */
function contract_admin_prepare_head()
{
	global $langs, $config, $db;

	$extrafields = new ExtraFields($db);
	$extrafields->fetch_name_optionals_label('contract');
	$extrafields->fetch_name_optionals_label('contractdet');

	$h = 0;
	$head = [];

	$head[$h][0] = DOL_URL_ROOT . "/admin/contract.php";
	$head[$h][1] = $langs->trans("Contracts");
	$head[$h][2] = 'contract';
	$h++;

	// Show more tabs from modules
	// Entries must be declared in modules descriptor with line
	// $this->tabs = array('entity:+tabname:Title:@mymodule:/mymodule/mypage.php?id=__ID__');   to add new tab
	// $this->tabs = array('entity:-tabname:Title:@mymodule:/mymodule/mypage.php?id=__ID__');   to remove a tab
	complete_head_from_modules($config, $langs, null, $head, $h, 'contract_admin', 'add', 'core');

	$head[$h][0] = DOL_URL_ROOT . '/contract/admin/contract_extrafields.php';
	$head[$h][1] = $langs->trans("ExtraFields");
	$nbExtrafields = $extrafields->attributes['contract']['count'];
	if ($nbExtrafields > 0) {
		$head[$h][1] .= '<span class="badge marginleftonlyshort">' . $nbExtrafields . '</span>';
	}
	$head[$h][2] = 'attributes';
	$h++;

	$head[$h][0] = DOL_URL_ROOT . '/contract/admin/contractdet_extrafields.php';
	$head[$h][1] = $langs->trans("ExtraFieldsLines");
	$nbExtrafields = $extrafields->attributes['contractdet']['count'];
	if ($nbExtrafields > 0) {
		$head[$h][1] .= '<span class="badge marginleftonlyshort">' . $nbExtrafields . '</span>';
	}
	$head[$h][2] = 'attributeslines';
	$h++;

	complete_head_from_modules($config, $langs, null, $head, $h, 'contract_admin', 'add', 'external');

	complete_head_from_modules($config, $langs, null, $head, $h, 'contract_admin', 'remove');

	return $head;
}
