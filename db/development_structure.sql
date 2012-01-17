--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: access_levels; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE access_levels (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL
);


--
-- Name: access_levels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE access_levels_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: access_levels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE access_levels_id_seq OWNED BY access_levels.id;


--
-- Name: batches; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE batches (
    id integer NOT NULL,
    user_id integer NOT NULL
);


--
-- Name: batches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE batches_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: batches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE batches_id_seq OWNED BY batches.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE comments (
    id integer NOT NULL,
    content text,
    user_id integer,
    stored_file_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comments_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: content_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE content_types (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: content_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE content_types_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: content_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE content_types_id_seq OWNED BY content_types.id;


--
-- Name: disposition_actions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE disposition_actions (
    id integer NOT NULL,
    action character varying(255)
);


--
-- Name: disposition_actions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE disposition_actions_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: disposition_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE disposition_actions_id_seq OWNED BY disposition_actions.id;


--
-- Name: dispositions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dispositions (
    id integer NOT NULL,
    disposition_action_id integer,
    stored_file_id integer,
    location text,
    note text,
    action_date timestamp without time zone
);


--
-- Name: dispositions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dispositions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: dispositions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dispositions_id_seq OWNED BY dispositions.id;


--
-- Name: flaggings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE flaggings (
    id integer NOT NULL,
    flag_id integer,
    stored_file_id integer,
    user_id integer,
    note text
);


--
-- Name: flaggings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE flaggings_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: flaggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE flaggings_id_seq OWNED BY flaggings.id;


--
-- Name: flags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE flags (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL
);


--
-- Name: flags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE flags_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: flags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE flags_id_seq OWNED BY flags.id;


--
-- Name: groups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE groups (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    assignable_rights boolean DEFAULT false
);


--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE groups_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE groups_id_seq OWNED BY groups.id;


--
-- Name: groups_owners; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE groups_owners (
    group_id integer,
    owner_id integer
);


--
-- Name: groups_stored_files; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE groups_stored_files (
    id integer NOT NULL,
    group_id integer,
    stored_file_id integer
);


--
-- Name: groups_stored_files_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE groups_stored_files_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: groups_stored_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE groups_stored_files_id_seq OWNED BY groups_stored_files.id;


--
-- Name: groups_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE groups_users (
    user_id integer,
    group_id integer
);


--
-- Name: licenses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE licenses (
    id integer NOT NULL,
    stored_file_id integer,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: licenses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE licenses_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: licenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE licenses_id_seq OWNED BY licenses.id;


--
-- Name: mime_type_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mime_type_categories (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: mime_type_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mime_type_categories_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: mime_type_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mime_type_categories_id_seq OWNED BY mime_type_categories.id;


--
-- Name: mime_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mime_types (
    id integer NOT NULL,
    name character varying(255),
    extension character varying(255),
    mime_type character varying(255),
    mime_type_category_id integer,
    blacklist boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: mime_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mime_types_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: mime_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mime_types_id_seq OWNED BY mime_types.id;


--
-- Name: preferences; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE preferences (
    id integer NOT NULL,
    name character varying(255),
    value character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE preferences_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE preferences_id_seq OWNED BY preferences.id;


--
-- Name: right_assignments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE right_assignments (
    id integer NOT NULL,
    right_id integer,
    subject_id integer,
    subject_type character varying(255)
);


--
-- Name: right_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE right_assignments_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: right_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE right_assignments_id_seq OWNED BY right_assignments.id;


--
-- Name: rights; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE rights (
    id integer NOT NULL,
    action character varying(255),
    description character varying(255)
);


--
-- Name: rights_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rights_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: rights_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rights_id_seq OWNED BY rights.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE roles (
    id integer NOT NULL,
    name character varying(40),
    authorizable_type character varying(40),
    authorizable_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: roles_groups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE roles_groups (
    group_id integer,
    role_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE roles_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: roles_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE roles_users (
    user_id integer,
    role_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: sftp_groups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sftp_groups (
    id integer NOT NULL,
    name character varying(255),
    members text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: sftp_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sftp_users (
    user_id integer NOT NULL,
    username character varying(255),
    passwd character varying(255),
    uid integer,
    sftp_group_id integer,
    homedir character varying(255),
    shell character varying(255),
    active boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: stored_files; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE stored_files (
    id integer NOT NULL,
    batch_id integer,
    user_id integer NOT NULL,
    title character varying(255),
    original_filename character varying(255),
    office character varying(255),
    access_level_id integer NOT NULL,
    content_type_id integer,
    format_version character varying(255),
    md5 character varying(255),
    file_size integer,
    description text,
    copyright text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    file character varying(255),
    author character varying(255),
    license_id integer,
    deletion_date timestamp without time zone,
    allow_notes boolean DEFAULT false,
    delete_flag boolean,
    allow_tags boolean,
    mime_type_id integer
);


--
-- Name: stored_files_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stored_files_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: stored_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stored_files_id_seq OWNED BY stored_files.id;


--
-- Name: taggings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE taggings (
    id integer NOT NULL,
    tag_id integer,
    taggable_id integer,
    taggable_type character varying(255),
    tagger_id integer,
    tagger_type character varying(255),
    context character varying(255),
    created_at timestamp without time zone
);


--
-- Name: taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taggings_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taggings_id_seq OWNED BY taggings.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tags (
    id integer NOT NULL,
    name character varying(255)
);


--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tags_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(128) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    name character varying(255) NOT NULL,
    affiliation character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    quota_used integer,
    quota_max integer
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE access_levels ALTER COLUMN id SET DEFAULT nextval('access_levels_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE batches ALTER COLUMN id SET DEFAULT nextval('batches_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE content_types ALTER COLUMN id SET DEFAULT nextval('content_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE disposition_actions ALTER COLUMN id SET DEFAULT nextval('disposition_actions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dispositions ALTER COLUMN id SET DEFAULT nextval('dispositions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE flaggings ALTER COLUMN id SET DEFAULT nextval('flaggings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE flags ALTER COLUMN id SET DEFAULT nextval('flags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE groups ALTER COLUMN id SET DEFAULT nextval('groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE groups_stored_files ALTER COLUMN id SET DEFAULT nextval('groups_stored_files_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE licenses ALTER COLUMN id SET DEFAULT nextval('licenses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE mime_type_categories ALTER COLUMN id SET DEFAULT nextval('mime_type_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE mime_types ALTER COLUMN id SET DEFAULT nextval('mime_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE preferences ALTER COLUMN id SET DEFAULT nextval('preferences_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE right_assignments ALTER COLUMN id SET DEFAULT nextval('right_assignments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE rights ALTER COLUMN id SET DEFAULT nextval('rights_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE stored_files ALTER COLUMN id SET DEFAULT nextval('stored_files_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE taggings ALTER COLUMN id SET DEFAULT nextval('taggings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: access_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY access_levels
    ADD CONSTRAINT access_levels_pkey PRIMARY KEY (id);


--
-- Name: batches_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY batches
    ADD CONSTRAINT batches_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: content_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY content_types
    ADD CONSTRAINT content_types_pkey PRIMARY KEY (id);


--
-- Name: disposition_actions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY disposition_actions
    ADD CONSTRAINT disposition_actions_pkey PRIMARY KEY (id);


--
-- Name: dispositions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dispositions
    ADD CONSTRAINT dispositions_pkey PRIMARY KEY (id);


--
-- Name: flaggings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY flaggings
    ADD CONSTRAINT flaggings_pkey PRIMARY KEY (id);


--
-- Name: flags_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY flags
    ADD CONSTRAINT flags_pkey PRIMARY KEY (id);


--
-- Name: groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: groups_stored_files_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY groups_stored_files
    ADD CONSTRAINT groups_stored_files_pkey PRIMARY KEY (id);


--
-- Name: licenses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY licenses
    ADD CONSTRAINT licenses_pkey PRIMARY KEY (id);


--
-- Name: mime_type_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mime_type_categories
    ADD CONSTRAINT mime_type_categories_pkey PRIMARY KEY (id);


--
-- Name: mime_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mime_types
    ADD CONSTRAINT mime_types_pkey PRIMARY KEY (id);


--
-- Name: preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY preferences
    ADD CONSTRAINT preferences_pkey PRIMARY KEY (id);


--
-- Name: right_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY right_assignments
    ADD CONSTRAINT right_assignments_pkey PRIMARY KEY (id);


--
-- Name: rights_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rights
    ADD CONSTRAINT rights_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: sftp_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sftp_groups
    ADD CONSTRAINT sftp_groups_pkey PRIMARY KEY (id);


--
-- Name: sftp_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sftp_users
    ADD CONSTRAINT sftp_users_pkey PRIMARY KEY (user_id);


--
-- Name: stored_files_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY stored_files
    ADD CONSTRAINT stored_files_pkey PRIMARY KEY (id);


--
-- Name: taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_mime_types_on_mime_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_mime_types_on_mime_type ON mime_types USING btree (mime_type);


--
-- Name: index_taggings_on_tag_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taggings_on_tag_id ON taggings USING btree (tag_id);


--
-- Name: index_taggings_on_taggable_id_and_taggable_type_and_context; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taggings_on_taggable_id_and_taggable_type_and_context ON taggings USING btree (taggable_id, taggable_type, context);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20111003172728');

INSERT INTO schema_migrations (version) VALUES ('20111003173036');

INSERT INTO schema_migrations (version) VALUES ('20111003173230');

INSERT INTO schema_migrations (version) VALUES ('20111003173252');

INSERT INTO schema_migrations (version) VALUES ('20111003174659');

INSERT INTO schema_migrations (version) VALUES ('20111003174709');

INSERT INTO schema_migrations (version) VALUES ('20111003174930');

INSERT INTO schema_migrations (version) VALUES ('20111003180658');

INSERT INTO schema_migrations (version) VALUES ('20111005191916');

INSERT INTO schema_migrations (version) VALUES ('20111005193256');

INSERT INTO schema_migrations (version) VALUES ('20111005194358');

INSERT INTO schema_migrations (version) VALUES ('20111010231842');

INSERT INTO schema_migrations (version) VALUES ('20111010234903');

INSERT INTO schema_migrations (version) VALUES ('20111011172429');

INSERT INTO schema_migrations (version) VALUES ('20111013023416');

INSERT INTO schema_migrations (version) VALUES ('20111014030058');

INSERT INTO schema_migrations (version) VALUES ('20111017160210');

INSERT INTO schema_migrations (version) VALUES ('20111017181315');

INSERT INTO schema_migrations (version) VALUES ('20111017183511');

INSERT INTO schema_migrations (version) VALUES ('20111017183629');

INSERT INTO schema_migrations (version) VALUES ('20111018194204');

INSERT INTO schema_migrations (version) VALUES ('20111020145216');

INSERT INTO schema_migrations (version) VALUES ('20111020182549');

INSERT INTO schema_migrations (version) VALUES ('20111021054620');

INSERT INTO schema_migrations (version) VALUES ('20111021062654');

INSERT INTO schema_migrations (version) VALUES ('20111021130855');

INSERT INTO schema_migrations (version) VALUES ('20111021144540');

INSERT INTO schema_migrations (version) VALUES ('20111024180253');

INSERT INTO schema_migrations (version) VALUES ('20111025134609');

INSERT INTO schema_migrations (version) VALUES ('20111025135847');

INSERT INTO schema_migrations (version) VALUES ('20111031134614');

INSERT INTO schema_migrations (version) VALUES ('20111101132701');

INSERT INTO schema_migrations (version) VALUES ('20111102001013');

INSERT INTO schema_migrations (version) VALUES ('20111102211526');

INSERT INTO schema_migrations (version) VALUES ('20111102211803');

INSERT INTO schema_migrations (version) VALUES ('20111103134904');

INSERT INTO schema_migrations (version) VALUES ('20111103134913');

INSERT INTO schema_migrations (version) VALUES ('20111103135909');

INSERT INTO schema_migrations (version) VALUES ('20111104152416');

INSERT INTO schema_migrations (version) VALUES ('20111107173440');

INSERT INTO schema_migrations (version) VALUES ('20111107204438');

INSERT INTO schema_migrations (version) VALUES ('20111108124011');

INSERT INTO schema_migrations (version) VALUES ('20111116212631');

INSERT INTO schema_migrations (version) VALUES ('20111117123049');

INSERT INTO schema_migrations (version) VALUES ('20111117123135');

INSERT INTO schema_migrations (version) VALUES ('20111117123521');