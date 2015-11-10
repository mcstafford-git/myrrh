Summary:

  MySQL Recursive Role Handler (myrrh) is a privilege management tool.
  Copyright (C) 2015 Mark C. Stafford <mark.stafford@gmail.com>

  Being able to grant privileges in a uniform manner supports
  reproducibility. Reproducibility leads to fewer problems. Fewer
  problems leads to happier people.

  This project would have been more timely prior to MariaDB having
  implemented roles in its privilege system, however this can still
  be useful for reverse engineering roles, auditability and recursion.

Copying:

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or (at
  your option) any later version.

  This program is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program. If not, see http://www.gnu.org/licenses/.

Installation:

  1) [Optional] Review myrrh.conf. If changes are made, run mksetup
     to rewrite myrrh-setup.sql
  2) Source myrrh-setup.sql as a fully privileged user
  3) Take a look at other/demo and/or other/reverse content for usage
     examples.

TODO:
  - consider using CSVs as an option for granting multiple elements at once
  - drop_*
  - implement remainder of changes to status
  - split out implementation of apply routines


