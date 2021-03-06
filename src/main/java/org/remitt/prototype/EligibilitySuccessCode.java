/*
 * $Id$
 *
 * Authors:
 *      Jeff Buchbinder <jeff@freemedsoftware.org>
 *
 * REMITT Electronic Medical Information Translation and Transmission
 * Copyright (C) 1999-2011 FreeMED Software Foundation
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

package org.remitt.prototype;

public enum EligibilitySuccessCode {
	SUCCESS("SUCCESS"), VALIDATION_FAILURE("VALIDATION_FAILURE"), PAYER_TIMEOUT(
			"PAYER_TIMEOUT"), PAYER_NOT_SUPPORTED("PAYER_NOT_SUPPORTED"), SYSTEM_ERROR(
			"SYSTEM_ERROR"), PAYER_ENROLLMENT_REQUIRED(
			"PAYER_ENROLLMENT_REQUIRED"), PROVIDER_ENROLLMENT_REQUIRED(
			"PROVIDER_ENROLLMENT_REQUIRED"), PRODUCT_REQUIRED(
			"PRODUCT_REQUIRED");

	private final String value;

	private EligibilitySuccessCode(String value) {
		this.value = value;
	}

	public String getValue() {
		return this.value;
	}

	public String toString() {
		return this.value;
	}
}
