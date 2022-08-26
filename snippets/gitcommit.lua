-- stylua: ignore
return {
    s("cc", {
        i(1, "type"),
        t("("),
        i(2, "scope"),
        t("): "),
        i(3, "title"),
    }),

    s("fix", {
        t("fix("),
        i(1, "scope"),
        t("): "),
        i(2, "title"),
    }),

    s("feat", {
        t("feat("),
        i(1, "scope"),
        t("): "),
        i(2, "title"),
    }),

    s("build", {
        t("build("),
        i(1, "scope"),
        t("): "),
        i(2, "title"),
    }),

    s("chore", {
        t("chore("),
        i(1, "scope"),
        t("): "),
        i(2, "title"),
    }),

    s("ci", {
        t("ci("),
        i(1, "scope"),
        t("): "),
        i(2, "title"),
    }),

    s("docs", {
        t("docs("),
        i(1, "scope"),
        t("): "),
        i(2, "title"),
    }),

    s("style", {
        t("style("),
        i(1, "scope"),
        t("): "),
        i(2, "title"),
    }),

    s("refactor", {
        t("refactor("),
        i(1, "scope"),
        t("): "),
        i(2, "title"),
    }),

    s("perf", {
        t("perf("),
        i(1, "scope"),
        t("): "),
        i(2, "title"),
    }),

    s("test", {
        t("test("),
        i(1, "scope"),
        t("): "),
        i(2, "title"),
    }),

    s("BREAK", {
        t("BREAKING CHANGE: "),
        i(1),
    }),
}
