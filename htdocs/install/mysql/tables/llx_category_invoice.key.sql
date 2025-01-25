-- ============================================================================
-- Copyright (C) 2007 Patrick Raguin     <patrick.raguin@gmail.com>
-- Copyright (C) 2022 Solution Libre SAS <contact@solution-libre.fr>
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

ALTER TABLE llx_category_invoice ADD PRIMARY KEY pk_category_invoice (fk_category, fk_invoice);
ALTER TABLE llx_category_invoice ADD INDEX idx_category_invoice_fk_category (fk_category);
ALTER TABLE llx_category_invoice ADD INDEX idx_category_invoice_fk_invoice (fk_invoice);

ALTER TABLE llx_category_invoice ADD CONSTRAINT fk_category_invoice_category_rowid FOREIGN KEY (fk_category) REFERENCES llx_category (rowid);
ALTER TABLE llx_category_invoice ADD CONSTRAINT fk_category_invoice_fk_invoice_rowid FOREIGN KEY (fk_invoice) REFERENCES llx_facture (rowid);
