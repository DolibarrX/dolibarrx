-- ============================================================================
-- Copyright (C) 2016	Charlie Benke	<charlie@patas-monkey.com>
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

ALTER TABLE llx_category_user ADD PRIMARY KEY pk_category_user (fk_category, fk_user);
ALTER TABLE llx_category_user ADD INDEX idx_category_user_fk_category (fk_category);
ALTER TABLE llx_category_user ADD INDEX idx_category_user_fk_user (fk_user);

ALTER TABLE llx_category_user ADD CONSTRAINT fk_category_user_category_rowid FOREIGN KEY (fk_category) REFERENCES llx_category (rowid);
ALTER TABLE llx_category_user ADD CONSTRAINT fk_category_user_fk_user FOREIGN KEY (fk_user) REFERENCES llx_user (rowid);

