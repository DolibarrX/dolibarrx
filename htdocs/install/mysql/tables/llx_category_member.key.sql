-- ============================================================================
-- Copyright (C) 2005      Brice Davoleau       <e1davole@iu-vannes.fr>
-- Copyright (C) 2005      Matthieu Valleton    <mv@seeschloss.org>		
-- Copyright (C) 2005-2010 Laurent Destailleur  <eldy@users.sourceforge.net>
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

ALTER TABLE llx_category_member ADD PRIMARY KEY pk_category_member (fk_category, fk_member);
ALTER TABLE llx_category_member ADD INDEX idx_category_member_fk_category (fk_category);
ALTER TABLE llx_category_member ADD INDEX idx_category_member_fk_member (fk_member);

ALTER TABLE llx_category_member ADD CONSTRAINT fk_category_member_category_rowid FOREIGN KEY (fk_category) REFERENCES llx_category (rowid);
ALTER TABLE llx_category_member ADD CONSTRAINT fk_category_member_member_rowid   FOREIGN KEY (fk_member) REFERENCES llx_member (rowid);
