-- ============================================================================
-- Copyright (C) 2007 Patrick Raguin            <patrick.raguin@gmail.com>
-- Copyright (C) 2019 Quentin Vial-Gouteyron    <quentin.vial-gouteyron@atm-consulting.fr>
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
-- along with this program. If not, see <http://www.gnu.org/licenses/>.
--
-- ============================================================================

ALTER TABLE llx_category_warehouse ADD PRIMARY KEY pk_category_warehouse (fk_category, fk_warehouse);
ALTER TABLE llx_category_warehouse ADD INDEX idx_category_warehouse_fk_category (fk_category);
ALTER TABLE llx_category_warehouse ADD INDEX idx_category_warehouse_fk_warehouse (fk_warehouse);

ALTER TABLE llx_category_warehouse ADD CONSTRAINT fk_category_warehouse_category_rowid FOREIGN KEY (fk_category) REFERENCES llx_category (rowid);
ALTER TABLE llx_category_warehouse ADD CONSTRAINT fk_category_warehouse_fk_warehouse_rowid FOREIGN KEY (fk_warehouse) REFERENCES llx_entrepot (rowid);
