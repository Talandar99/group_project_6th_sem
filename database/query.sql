--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.2

-- Started on 2025-03-14 22:35:16

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16387)
-- Name: phinxlog; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.phinxlog (
    version bigint NOT NULL,
    migration_name character varying(100),
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    breakpoint boolean DEFAULT false NOT NULL
);


ALTER TABLE public.phinxlog OWNER TO "user";

--
-- TOC entry 219 (class 1259 OID 16394)
-- Name: users; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    modified timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO "user";

--
-- TOC entry 218 (class 1259 OID 16393)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO "user";

--
-- TOC entry 3377 (class 0 OID 0)
-- Dependencies: 218
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3215 (class 2604 OID 16397)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3369 (class 0 OID 16387)
-- Dependencies: 217
-- Data for Name: phinxlog; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.phinxlog (version, migration_name, start_time, end_time, breakpoint) FROM stdin;
\.


--
-- TOC entry 3371 (class 0 OID 16394)
-- Dependencies: 219
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.users (id, email, password, created, modified) FROM stdin;
4	user@example.com	$2y$10$ItfknrjtNSHA0V88WYye2ufDgtoZkQDRVdDeqIFcoJqBG5cVcCOwy	2025-03-14 21:10:10.341707+00	2025-03-14 21:10:10.341707+00
\.


--
-- TOC entry 3378 (class 0 OID 0)
-- Dependencies: 218
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- TOC entry 3219 (class 2606 OID 16392)
-- Name: phinxlog phinxlog_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.phinxlog
    ADD CONSTRAINT phinxlog_pkey PRIMARY KEY (version);


--
-- TOC entry 3221 (class 2606 OID 16405)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 3223 (class 2606 OID 16403)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


-- Completed on 2025-03-14 22:35:17

--
-- PostgreSQL database dump complete
--

