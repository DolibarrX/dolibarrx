-- ============================================================================
-- Copyright (C) 2009 Laurent Destailleur <eldy@users.sourceforge.net>
-- Copyright (C) 2009 Regis Houssin       <regis.houssin@inodbox.com>
--
-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program. If not, see <https://www.gnu.org/licenses/>.
--
-- ============================================================================


ALTER TABLE llx_member ADD UNIQUE INDEX uk_member_login (login, entity);
ALTER TABLE llx_member ADD UNIQUE INDEX uk_member_ref (ref, entity);
ALTER TABLE llx_member ADD UNIQUE INDEX uk_member_fk_soc (fk_soc);

ALTER TABLE llx_member ADD INDEX idx_member_fk_member_type (fk_member_type);

ALTER TABLE llx_member ADD CONSTRAINT member_fk_soc FOREIGN KEY (fk_soc) REFERENCES llx_societe (rowid);
ALTER TABLE llx_member ADD CONSTRAINT fk_member_member_type FOREIGN KEY (fk_member_type)    REFERENCES llx_member_type (rowid);
