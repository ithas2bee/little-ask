CREATE TABLE "family_relationships" (
	"id" uuid PRIMARY KEY NOT NULL,
	"parent_account_id" uuid NOT NULL,
	"child_profile_id" uuid NOT NULL,
	"status" text DEFAULT 'approved' NOT NULL,
	CONSTRAINT "family_relationships_status_approved" CHECK ("family_relationships"."status" = 'approved'),
	CONSTRAINT "family_relationships_distinct_participants" CHECK ("family_relationships"."parent_account_id" <> "family_relationships"."child_profile_id")
);
--> statement-breakpoint
CREATE UNIQUE INDEX "family_relationships_participants_unique" ON "family_relationships" USING btree ("parent_account_id","child_profile_id");