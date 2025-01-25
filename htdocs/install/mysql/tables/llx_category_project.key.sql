-- ============================================================================
-- Copyright (C) 2007 Patrick Raguin       <patrick.raguin@gmail.com>
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

ALTER TABLE llx_category_project ADD PRIMARY KEY pk_category_project (fk_category, fk_project);
ALTER TABLE llx_category_project ADD INDEX idx_category_project_fk_category (fk_category);
ALTER TABLE llx_category_project ADD INDEX idx_category_project_fk_project (fk_project);

ALTER TABLE llx_category_project ADD CONSTRAINT fk_category_project_category_rowid FOREIGN KEY (fk_category) REFERENCES llx_category (rowid);
ALTER TABLE llx_category_project ADD CONSTRAINT fk_category_project_fk_project_rowid FOREIGN KEY (fk_project) REFERENCES llx_projet (rowid);
